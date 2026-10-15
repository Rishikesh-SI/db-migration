-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_asset_list_permid
-- Type: INDEX

-- Name: ix_upp_asset_list_permid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_asset_list_permid ON upp.upp_asset_list USING btree (primary_entity_role_map_id);


--
