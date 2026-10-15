-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: lablsg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON lablsg.lablsg_ad USING btree (ad_type);


--
