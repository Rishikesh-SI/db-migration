-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_assetlist_array_tag_ent
-- Type: INDEX

-- Name: ix_assetlist_array_tag_ent; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_assetlist_array_tag_ent ON labyho.labyho_asset_list USING gin (tagged_entity public.gin__int_ops);


--
