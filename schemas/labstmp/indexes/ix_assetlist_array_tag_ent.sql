-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_assetlist_array_tag_ent
-- Type: INDEX

-- Name: ix_assetlist_array_tag_ent; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_assetlist_array_tag_ent ON labstmp.labstmp_asset_list USING gin (tagged_entity public.gin__int_ops);


--
