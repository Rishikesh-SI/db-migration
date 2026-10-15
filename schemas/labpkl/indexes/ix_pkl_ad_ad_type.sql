-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_ad_ad_type
-- Type: INDEX

-- Name: ix_pkl_ad_ad_type; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_ad_ad_type ON labpkl.labpkl_ad USING btree (ad_type);


--
