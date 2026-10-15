-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_assetlist_core_partial
-- Type: INDEX

-- Name: idx_assetlist_core_partial; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_assetlist_core_partial ON labgt01_v1.labgt01_v1_asset_list USING btree (published_date DESC) WHERE ((is_active = (1)::numeric) AND (is_deleted = (0)::numeric) AND (is_published = (1)::numeric) AND (web_listing_json IS NOT NULL));


--
