-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_asset_list_sermid
-- Type: INDEX

-- Name: ix_tsk_asset_list_sermid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_asset_list_sermid ON labtcs.labtcs_asset_list USING btree (secondary_entity_role_map_id);


--
