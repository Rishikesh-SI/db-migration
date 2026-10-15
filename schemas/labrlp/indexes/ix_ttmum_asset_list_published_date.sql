-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labrlp.labrlp_asset_list USING btree (published_date);


--
