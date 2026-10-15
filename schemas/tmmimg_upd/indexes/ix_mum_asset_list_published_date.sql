-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_asset_list_published_date
-- Type: INDEX

-- Name: ix_mum_asset_list_published_date; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_asset_list_published_date ON tmmimg_upd.tmmimg_upd_asset_list USING btree (published_date);


--
