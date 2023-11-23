%%--------------------------------------------------------------------
%% Copyright (c) 2023 EMQ Technologies Co., Ltd. All Rights Reserved.
%%--------------------------------------------------------------------
-module(emqx_bridge_matrix).

-export([
    conn_bridge_examples/1
]).

-export([
    namespace/0,
    roots/0,
    fields/1,
    desc/1
]).

%% Examples
-export([
    bridge_v2_examples/1,
    connector_examples/1
]).

%% -------------------------------------------------------------------------------------------------
%% api

conn_bridge_examples(Method) ->
    [
        #{
            <<"matrix">> => #{
                summary => <<"Matrix Bridge">>,
                value => emqx_bridge_pgsql:values_conn_bridge_examples(Method, matrix)
            }
        }
    ].

%% -------------------------------------------------------------------------------------------------
%% Hocon Schema Definitions
namespace() -> "bridge_matrix".

roots() -> [].

fields("post") ->
    emqx_bridge_pgsql:fields("post", matrix);
fields("config_connector") ->
    emqx_bridge_pgsql:fields("config_connector");
fields(action) ->
    {matrix,
        hoconsc:mk(
            hoconsc:map(name, hoconsc:ref(emqx_bridge_pgsql, pgsql_action)),
            #{
                desc => <<"Matrix Action Config">>,
                required => false
            }
        )};
fields("put_bridge_v2") ->
    emqx_bridge_pgsql:fields(pgsql_action);
fields("get_bridge_v2") ->
    emqx_bridge_pgsql:fields(pgsql_action);
fields("post_bridge_v2") ->
    emqx_bridge_pgsql:fields(pgsql_action);
fields("put_connector") ->
    emqx_bridge_pgsql:fields("config_connector");
fields("get_connector") ->
    emqx_bridge_pgsql:fields("config_connector");
fields("post_connector") ->
    emqx_bridge_pgsql:fields("config_connector");
fields(Method) ->
    emqx_bridge_pgsql:fields(Method).

desc(_) ->
    undefined.

%% Examples

connector_examples(Method) ->
    [
        #{
            <<"matrix">> => #{
                summary => <<"Matrix Connector">>,
                value => emqx_postgresql_connector_schema:values({Method, connector})
            }
        }
    ].

bridge_v2_examples(Method) ->
    [
        #{
            <<"matrix">> => #{
                summary => <<"Matrix Action">>,
                value => emqx_bridge_pgsql:values({Method, matrix})
            }
        }
    ].
