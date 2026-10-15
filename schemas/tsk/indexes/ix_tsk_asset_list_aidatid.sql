-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_asset_list_aidatid
-- Type: INDEX

-- Name: ix_tsk_asset_list_aidatid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_asset_list_aidatid ON tsk.tsk_asset_list USING btree (asset_id, asset_type_id);


--
