-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: idx_assetlist_corefilter
-- Type: INDEX

-- Name: idx_assetlist_corefilter; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX idx_assetlist_corefilter ON labwis.labwis_asset_list USING btree (is_active, is_deleted, is_published, asset_type_id, published_date DESC);


--
