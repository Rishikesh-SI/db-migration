-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_assetlist_published_date
-- Type: INDEX

-- Name: ix_assetlist_published_date; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_assetlist_published_date ON labyho.labyho_asset_list USING btree (published_date DESC);


--
