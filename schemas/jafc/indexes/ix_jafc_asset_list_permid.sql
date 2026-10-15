-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_asset_list_permid
-- Type: INDEX

-- Name: ix_jafc_asset_list_permid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_asset_list_permid ON jafc.jafc_asset_list USING btree (primary_entity_role_map_id);


--
