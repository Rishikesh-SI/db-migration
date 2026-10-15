-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_site_partner_sid
-- Type: INDEX

-- Name: ix_spz_site_partner_sid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_site_partner_sid ON spz.spz_site_partner USING btree (site_id);


--
