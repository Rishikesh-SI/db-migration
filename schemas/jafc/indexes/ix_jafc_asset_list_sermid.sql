-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_asset_list_sermid
-- Type: INDEX

-- Name: ix_jafc_asset_list_sermid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_asset_list_sermid ON jafc.jafc_asset_list USING btree (secondary_entity_role_map_id);


--
