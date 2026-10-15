-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: combine_idx
-- Type: INDEX

-- Name: combine_idx; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX combine_idx ON labrr.labrr_web_user_membership USING btree (user_guid, campaign_id, ((campaign_json ->> 'membership_start_date'::text)));


--
