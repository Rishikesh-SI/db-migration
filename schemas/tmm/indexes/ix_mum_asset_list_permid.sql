-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_asset_list_permid
-- Type: INDEX

-- Name: ix_mum_asset_list_permid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_asset_list_permid ON tmm.tmm_asset_list USING btree (primary_entity_role_map_id);


--
