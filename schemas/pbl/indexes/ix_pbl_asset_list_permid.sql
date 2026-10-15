-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_asset_list_permid
-- Type: INDEX

-- Name: ix_pbl_asset_list_permid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_asset_list_permid ON pbl.pbl_asset_list USING btree (primary_entity_role_map_id);


--
