-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_asset_list_published_date
-- Type: INDEX

-- Name: ix_jafc_asset_list_published_date; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_asset_list_published_date ON jafc.jafc_asset_list USING btree (published_date);


--
