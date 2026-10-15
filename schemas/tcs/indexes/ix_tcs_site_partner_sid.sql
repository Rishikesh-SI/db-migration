-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_site_partner_sid
-- Type: INDEX

-- Name: ix_tcs_site_partner_sid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_site_partner_sid ON tcs.tcs_site_partner USING btree (site_id);


--
