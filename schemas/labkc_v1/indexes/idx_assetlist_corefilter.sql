-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_assetlist_corefilter
-- Type: INDEX

-- Name: idx_assetlist_corefilter; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_assetlist_corefilter ON labkc_v1.labkc_v1_asset_list USING btree (is_active, is_deleted, is_published, asset_type_id, published_date DESC);


--
