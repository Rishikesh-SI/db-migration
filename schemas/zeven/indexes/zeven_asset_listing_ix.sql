-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_listing_ix
-- Type: INDEX

-- Name: zeven_asset_listing_ix; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX zeven_asset_listing_ix ON zeven.zeven_asset_listing USING btree (id, is_published, is_deleted, catid);


--
