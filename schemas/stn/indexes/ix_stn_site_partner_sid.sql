-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_site_partner_sid
-- Type: INDEX

-- Name: ix_stn_site_partner_sid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_site_partner_sid ON stn.stn_site_partner USING btree (site_id);


--
