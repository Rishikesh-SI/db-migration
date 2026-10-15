-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_asset_list_published_date
-- Type: INDEX

-- Name: ix_zeven_asset_list_published_date; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_asset_list_published_date ON zeven.zeven_asset_list USING btree (published_date);


--
