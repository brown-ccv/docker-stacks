__precompile__(true)

module ModifyRegistry

import LibGit2
import Pkg

"""
    modify_registry(old_name, old_uuid, new_name, new_uuid; <keyword arguments>)

Modify the registry with name `old_name` and UUID `old_uuid`.

# Required Arguments
- `old_name`: the original name of the registry.
- `old_uuid`: the original UUID of the registry.
- `new_name`: the new name you want to assign to the registry.
- `new_uuid`: the new UUID you want to assign to the registry.

# Optional Keyword Arguments
- `user_name`: user name to use when committing. Defaults to "Stronghold Team".
- `user_email`: user email to use when committing. Defaults to "stronghold-help@brown.edu".
- `commit_msg`: commit message to use when committing. Defaults to "Updating registry details for Stronghold".

# Example
```julia-repl
julia> modify_registry("General", "23338594-aafe-5451-b93e-139f81909106", "StrongHoldGeneral", "a67460e4-2ee5-11e9-b210-d663bd873d93")
```
"""
function modify_registry end

modify_registry(
    old_name::AbstractString,
    old_uuid::AbstractString,
    new_name::AbstractString,
    new_uuid::AbstractString;
    kwargs...
    )::Nothing = modify_registry(
        old_name,
        Base.UUID(old_uuid),
        new_name,
        Base.UUID(new_uuid);
        kwargs...
        )

function modify_registry(
        old_name::AbstractString,
        old_uuid::Base.UUID,
        new_name::AbstractString,
        new_uuid::Base.UUID;
        user_name::AbstractString = "Stronghold Team",
        user_email::AbstractString = "stronghold-help@brown.edu",
        commit_msg::AbstractString = "Updating registry details for Stronghold"
        )::Nothing
    all_registries::Vector{Pkg.Types.RegistrySpec} =
        Pkg.Types.collect_registries()
    for r in all_registries
        # Fields:
        # r.name
        # r.uuid
        # r.url
        # r.path
        if r.name==old_name && r.uuid==old_uuid
            _modify_registry(
                r,
                new_name,
                new_uuid;
                user_name = user_name,
                user_email = user_email,
                commit_msg = commit_msg,
                )
            @info("Modified registry successfully.")
            return nothing
        end
    end
    @warn("Did not find matching registry")
    return nothing

end

function _modify_registry(
        r::Pkg.Types.RegistrySpec,
        new_name::AbstractString,
        new_uuid::Base.UUID;
        user_name::AbstractString,
        user_email::AbstractString,
        commit_msg::AbstractString,
        )::Nothing
    # Fields:
    # r.name
    # r.uuid
    # r.url
    # r.path
    new_registry_path::String = _move_registry(r, r.name, new_name,)
    r.path = new_registry_path
    _modify_registry_toml_file(r, new_name, new_uuid,)
    r.name = new_name
    r.uuid = new_uuid
    _git_commit(
        r;
        user_name = user_name,
        user_email = user_email,
        commit_msg = commit_msg,
        )
    _delete_all_remotes(r,)
    return nothing
end

function _git_commit(
        r::Pkg.Types.RegistrySpec;
        user_name::AbstractString,
        user_email::AbstractString,
        commit_msg::AbstractString,
        )::Nothing
    repo::LibGit2.GitRepo = LibGit2.GitRepo(r.path)
    sig::LibGit2.Signature = LibGit2.Signature(user_name, user_email,)
    LibGit2.add!(repo, "Registry.toml",)
    LibGit2.commit(
        repo,
        commit_msg;
        author = sig,
        committer = sig,
        )
    return nothing
end

function _modify_registry_toml_file(
        r::Pkg.Types.RegistrySpec,
        new_name::AbstractString,
        new_uuid::Base.UUID
        )::Nothing
    registry_toml_file_path::String = joinpath(r.path,"Registry.toml",)
    registry_toml_file_contents::String = read(registry_toml_file_path,String,)
    registry_toml_file_parsed::Dict{String, Any} = Pkg.TOML.parse(
        registry_toml_file_contents
        )
    registry_toml_file_parsed["name"] = new_name
    registry_toml_file_parsed["repo"] = r.path
    registry_toml_file_parsed["uuid"] = sprint(print, new_uuid,)
    registry_toml_file_contents = sprint(
        Pkg.TOML.print,
        registry_toml_file_parsed,
        )
    write(registry_toml_file_path, registry_toml_file_contents,)
    return nothing
end

function _delete_all_remotes(
        r::Pkg.Types.RegistrySpec,
        )::Nothing
    repo::LibGit2.GitRepo = LibGit2.GitRepo(r.path)
    all_remotes::Vector{String} = LibGit2.remotes(repo)
    for remote in all_remotes
        LibGit2.remote_delete(repo, remote,)
    end
    return nothing
end

function _move_registry(
        r::Pkg.Types.RegistrySpec,
        old_name::AbstractString,
        new_name::AbstractString,
        )::String
    old_registry_path = r.path
    registry_path_split = splitpath(r.path)
    if registry_path_split[end] == old_name
        registry_path_split[end] = new_name
        new_registry_path = joinpath(registry_path_split...)
        mv(
            old_registry_path,
            new_registry_path;
            force = true,
            )
        return new_registry_path
    else
        @warn(
            string(
                "r.path does not end in old_name, ",
                "so this step will be skipped",
                ),
            r.path,
            old_name,
            )
        return old_registry_path
    end
end

end # end module ModifyRegistry
