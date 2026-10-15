-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_ad_ad_type_idx
-- Type: INDEX

-- Name: upstox_ad_ad_type_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_ad_ad_type_idx ON upstox.upstox_ad USING btree (ad_type);


--
