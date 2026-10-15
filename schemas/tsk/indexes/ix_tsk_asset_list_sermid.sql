-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_asset_list_sermid
-- Type: INDEX

-- Name: ix_tsk_asset_list_sermid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_asset_list_sermid ON tsk.tsk_asset_list USING btree (secondary_entity_role_map_id);


--
