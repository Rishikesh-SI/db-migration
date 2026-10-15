-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: idx_assetlist_core_partial
-- Type: INDEX

-- Name: idx_assetlist_core_partial; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX idx_assetlist_core_partial ON labwis.labwis_asset_list USING btree (published_date DESC) WHERE ((is_active = (1)::numeric) AND (is_deleted = (0)::numeric) AND (is_published = (1)::numeric) AND (web_listing_json IS NOT NULL));


--
