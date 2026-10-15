-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labisl_v1.labisl_v1_asset_list USING btree (secondary_entity_role_map_id);


--
