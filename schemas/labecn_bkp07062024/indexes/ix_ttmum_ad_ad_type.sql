-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labecn_bkp07062024; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labecn_bkp07062024.labecn_ad USING btree (ad_type);


--
