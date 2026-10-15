-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_site_partner_sid
-- Type: INDEX

-- Name: ix_dd_site_partner_sid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_site_partner_sid ON dd.dd_site_partner USING btree (site_id);


--
