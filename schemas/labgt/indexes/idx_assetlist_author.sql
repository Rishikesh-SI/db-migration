-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_assetlist_author
-- Type: INDEX

-- Name: idx_assetlist_author; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_assetlist_author ON labgt.labgt_asset_list USING btree (author_id);


--
