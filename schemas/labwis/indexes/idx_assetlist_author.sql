-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: idx_assetlist_author
-- Type: INDEX

-- Name: idx_assetlist_author; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX idx_assetlist_author ON labwis.labwis_asset_list USING btree (author_id);


--
