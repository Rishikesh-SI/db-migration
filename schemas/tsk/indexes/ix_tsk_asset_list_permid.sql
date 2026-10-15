-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_asset_list_permid
-- Type: INDEX

-- Name: ix_tsk_asset_list_permid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_asset_list_permid ON tsk.tsk_asset_list USING btree (primary_entity_role_map_id);


--
