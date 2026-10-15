-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_asset_list_permid
-- Type: INDEX

-- Name: ix_khi_asset_list_permid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_asset_list_permid ON khi.khi_asset_list USING btree (primary_entity_role_map_id);


--
