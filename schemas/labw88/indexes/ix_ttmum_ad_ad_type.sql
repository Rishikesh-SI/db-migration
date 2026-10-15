-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labw88.labw88_ad USING btree (ad_type);


--
