-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_ad_ad_type_idx
-- Type: INDEX

-- Name: lablsg_ad_ad_type_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_ad_ad_type_idx ON fanxp_lsg.lablsg_ad USING btree (ad_type);


--
