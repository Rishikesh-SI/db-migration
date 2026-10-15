-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_labfih_asset_list_tagged_entity_gin_published
-- Type: INDEX

-- Name: idx_labfih_asset_list_tagged_entity_gin_published; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_labfih_asset_list_tagged_entity_gin_published ON labfih.labfih_asset_list USING gin (tagged_entity) WHERE ((is_published = (1)::numeric) AND (is_trashed = (0)::numeric) AND (asset_type_id = ANY (ARRAY[(1)::numeric, (2)::numeric, (4)::numeric, (5)::numeric, (29)::numeric])));


--
