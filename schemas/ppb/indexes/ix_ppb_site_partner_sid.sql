-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_site_partner_sid
-- Type: INDEX

-- Name: ix_ppb_site_partner_sid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_site_partner_sid ON ppb.ppb_site_partner USING btree (site_id);


--
