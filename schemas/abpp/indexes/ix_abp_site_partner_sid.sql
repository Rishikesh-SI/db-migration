-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_site_partner_sid
-- Type: INDEX

-- Name: ix_abp_site_partner_sid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_site_partner_sid ON abpp.abp_site_partner USING btree (site_id);


--
