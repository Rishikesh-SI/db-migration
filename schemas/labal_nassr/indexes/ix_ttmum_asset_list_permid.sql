-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_asset_list_permid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_permid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_permid ON labal_nassr.labal_nassr_asset_list USING btree (primary_entity_role_map_id);


--
