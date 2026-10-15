-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_ad_ad_type
-- Type: INDEX

-- Name: ix_pkl_ad_ad_type; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_ad_ad_type ON labpkl_v1.labpkl_v1_ad USING btree (ad_type);


--
