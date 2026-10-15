-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_site_partner_sid
-- Type: INDEX

-- Name: ix_khi_site_partner_sid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_site_partner_sid ON khi.khi_site_partner USING btree (site_id);


--
