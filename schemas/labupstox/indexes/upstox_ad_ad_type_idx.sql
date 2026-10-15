-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_ad_ad_type_idx
-- Type: INDEX

-- Name: upstox_ad_ad_type_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_ad_ad_type_idx ON labupstox.labupstox_ad USING btree (ad_type);


--
