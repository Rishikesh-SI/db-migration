-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_site_partner_sid
-- Type: INDEX

-- Name: ix_upp_site_partner_sid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_site_partner_sid ON upp.upp_site_partner USING btree (site_id);


--
