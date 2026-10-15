-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labisp.labisp_asset_list USING btree (primary_entity_role_map_id, asset_type_id);


--
