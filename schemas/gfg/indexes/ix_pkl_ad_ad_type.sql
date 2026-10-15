-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_ad_ad_type
-- Type: INDEX

-- Name: ix_pkl_ad_ad_type; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_ad_ad_type ON gfg.gfg_ad USING btree (ad_type);


--
