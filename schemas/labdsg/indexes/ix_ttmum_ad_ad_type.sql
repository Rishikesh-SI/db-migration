-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labdsg.labdsg_ad USING btree (ad_type);


--
