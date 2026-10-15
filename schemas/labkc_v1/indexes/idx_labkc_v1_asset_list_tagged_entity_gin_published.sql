-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_labkc_v1_asset_list_tagged_entity_gin_published
-- Type: INDEX

-- Name: idx_labkc_v1_asset_list_tagged_entity_gin_published; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_labkc_v1_asset_list_tagged_entity_gin_published ON labkc_v1.labkc_v1_asset_list USING gin (tagged_entity) WHERE ((is_published = (1)::numeric) AND (is_trashed = (0)::numeric) AND (asset_type_id = ANY (ARRAY[(1)::numeric, (2)::numeric, (4)::numeric, (5)::numeric, (29)::numeric])));


--
