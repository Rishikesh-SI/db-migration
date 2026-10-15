-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_ad_ad_type
-- Type: INDEX

-- Name: ix_gsf_ad_ad_type; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_ad_ad_type ON gsf.gsf_ad USING btree (ad_type);


--
