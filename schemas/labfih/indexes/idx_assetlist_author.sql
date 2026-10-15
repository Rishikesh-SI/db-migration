-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_assetlist_author
-- Type: INDEX

-- Name: idx_assetlist_author; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_assetlist_author ON labfih.labfih_asset_list USING btree (author_id);


--
