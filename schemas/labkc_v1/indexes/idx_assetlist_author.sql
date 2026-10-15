-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_assetlist_author
-- Type: INDEX

-- Name: idx_assetlist_author; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_assetlist_author ON labkc_v1.labkc_v1_asset_list USING btree (author_id);


--
