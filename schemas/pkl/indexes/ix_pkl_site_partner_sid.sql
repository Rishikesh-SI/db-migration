-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_site_partner_sid
-- Type: INDEX

-- Name: ix_pkl_site_partner_sid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_site_partner_sid ON pkl.pkl_site_partner USING btree (site_id);


--
