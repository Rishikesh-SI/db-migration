-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_asset_list_aidatid
-- Type: INDEX

-- Name: ix_jafc_asset_list_aidatid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_asset_list_aidatid ON jafc.jafc_asset_list USING btree (asset_id, asset_type_id);


--
