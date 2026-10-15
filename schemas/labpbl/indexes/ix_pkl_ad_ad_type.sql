-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_ad_ad_type
-- Type: INDEX

-- Name: ix_pkl_ad_ad_type; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_ad_ad_type ON labpbl.labpbl_ad USING btree (ad_type);


--
